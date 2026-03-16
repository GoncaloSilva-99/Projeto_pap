    // Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
    import "@hotwired/turbo-rails"
    import "controllers"
    import "@rails/request.js"
    Turbo.session.drive = false

     // --- Lógica de Upload de Imagem e Carrossel (Criação de Post) ---
                    const btnUploadImage = document.getElementById('btn-upload-image');
                    const fileInput = document.getElementById('post-image-upload');
                    const previewContainer = document.getElementById('image-preview-container');
                    const imageCarousel = document.getElementById('image-carousel');
                    const imageDots = document.getElementById('image-dots');
                    const prevImageBtn = document.getElementById('prev-image-btn');
                    const nextImageBtn = document.getElementById('next-image-btn');
                    let uploadedFiles = [];
                    
                    if (btnUploadImage && fileInput && previewContainer && imageCarousel && imageDots) {
                        // Botões de navegação do carrossel
                        if (prevImageBtn && nextImageBtn) {
                            prevImageBtn.addEventListener('click', (e) => {
                                e.preventDefault();
                                e.stopPropagation();
                                // Rola para a esquerda
                                imageCarousel.scrollBy({ left: -imageCarousel.offsetWidth, behavior: 'smooth' });
                            });

                            nextImageBtn.addEventListener('click', (e) => {
                                e.preventDefault();
                                e.stopPropagation();
                                // Rola para a direita
                                imageCarousel.scrollBy({ left: imageCarousel.offsetWidth, behavior: 'smooth' });
                            });
                        }

                        // Clicar no ícone de imagem abre o seletor de ficheiros
                        btnUploadImage.addEventListener('click', () => {
                            fileInput.click();
                        });

                        // Atualiza os pontinhos (indicadores) do carrossel
                        const updateDots = () => {
                            if (uploadedFiles.length === 0) return;

                            let currentIndex = 0;
                            if (uploadedFiles.length > 1) {
                                const scrollLeft = imageCarousel.scrollLeft;
                                const width = imageCarousel.offsetWidth;
                                // Calcula qual imagem está visível
                                currentIndex = Math.round(scrollLeft / width);
                            }
                            
                            // Garante que o índice é válido
                            currentIndex = Math.min(Math.max(currentIndex, 0), uploadedFiles.length - 1);
                            
                            const dots = imageDots.children;
                            for (let i = 0; i < dots.length; i++) {
                                if (i === currentIndex) {
                                    dots[i].classList.remove('bg-gray-600');
                                    dots[i].classList.add('bg-blue-500'); // Ativo
                                } else {
                                    dots[i].classList.add('bg-gray-600');
                                    dots[i].classList.remove('bg-blue-500'); // Inativo
                                }
                            }
                        };

                        // Renderiza (desenha) o carrossel com as imagens
                        const renderCarousel = () => {
                            imageCarousel.innerHTML = '';
                            imageDots.innerHTML = '';
                            
                            if (uploadedFiles.length === 0) {
                                previewContainer.classList.add('hidden');
                                return;
                            }

                            previewContainer.classList.remove('hidden');
                            
                            // Configura classes para snap (rolagem magnética) se houver mais de 1 imagem
                            if (uploadedFiles.length > 1) {
                                imageCarousel.classList.add('snap-x', 'snap-mandatory');
                                if (prevImageBtn) prevImageBtn.classList.remove('hidden');
                                if (nextImageBtn) nextImageBtn.classList.remove('hidden');
                            } else {
                                imageCarousel.classList.remove('snap-x', 'snap-mandatory');
                                if (prevImageBtn) prevImageBtn.classList.add('hidden');
                                if (nextImageBtn) nextImageBtn.classList.add('hidden');
                            }

                            // Cria os elementos para cada ficheiro
                            uploadedFiles.forEach((file, index) => {
                                const wrapper = document.createElement('div');
                                wrapper.className = `relative group flex-shrink-0 h-64 bg-gray-900 rounded-lg flex items-center justify-center ${uploadedFiles.length > 1 ? 'snap-center w-full' : 'w-full'}`;
                                
                                const img = document.createElement('img');
                                img.src = URL.createObjectURL(file); // Cria URL temporário para preview
                                img.alt = `Image preview ${index + 1}`;
                                img.className = "max-h-full max-w-full object-contain";
                                
                                // Botão de remover imagem
                                const btn = document.createElement('button');
                                btn.innerHTML = '<i data-feather="x" class="w-4 h-4"></i>';
                                btn.className = "absolute top-2 right-2 bg-gray-800 bg-opacity-75 text-white p-1 rounded-full opacity-0 group-hover:opacity-100 transition-opacity z-10 hover:bg-red-600";
                                btn.onclick = (e) => {
                                    e.stopPropagation();
                                    uploadedFiles.splice(index, 1); // Remove do array

                                    const dataTransfer = new DataTransfer();
                                    uploadedFiles.forEach(file => dataTransfer.items.add(file));
                                    fileInput.files = dataTransfer.files;

                                    renderCarousel(); // Redesenha
                                };
                                
                                wrapper.appendChild(img);
                                wrapper.appendChild(btn);
                                imageCarousel.appendChild(wrapper);

                                // Cria o ponto indicador
                                const dot = document.createElement('div');
                                dot.className = 'w-2 h-2 rounded-full transition-colors duration-200 bg-gray-600';
                                imageDots.appendChild(dot);
                            });
                            
                            feather.replace();
                            updateDots();
                        };

                        imageCarousel.addEventListener('scroll', () => {
                            updateDots();
                        });

                        // --- Lógica de Arrastar para Rolar (Drag to Scroll) ---
                        let isDown = false;
                        let startX;
                        let scrollLeft;

                        imageCarousel.addEventListener('mousedown', (e) => {
                            if (uploadedFiles.length <= 1) return;
                            isDown = true;
                            imageCarousel.classList.add('cursor-grabbing');
                            // Remove snap temporariamente para o arrasto ser suave
                            imageCarousel.classList.remove('cursor-grab', 'snap-x', 'snap-mandatory', 'scroll-smooth');
                            startX = e.pageX - imageCarousel.offsetLeft;
                            scrollLeft = imageCarousel.scrollLeft;
                        });

                        const stopDragging = () => {
                            if (!isDown) return;
                            isDown = false;
                            imageCarousel.classList.remove('cursor-grabbing');
                            imageCarousel.classList.add('cursor-grab', 'scroll-smooth');
                            // Reativa o snap
                            if (uploadedFiles.length > 1) imageCarousel.classList.add('snap-x', 'snap-mandatory');
                        };

                        imageCarousel.addEventListener('mouseleave', stopDragging);
                        imageCarousel.addEventListener('mouseup', stopDragging);

                        imageCarousel.addEventListener('mousemove', (e) => {
                            if (!isDown) return;
                            e.preventDefault();
                            const x = e.pageX - imageCarousel.offsetLeft;
                            const walk = (x - startX) * 2; // Velocidade do scroll
                            imageCarousel.scrollLeft = scrollLeft - walk;
                        });

                        // Quando o utilizador seleciona ficheiros
                        fileInput.addEventListener('change', function() {
                            if (this.files.length > 0) {
                                // Adiciona novos ficheiros ao array
                                const newFiles = Array.from(this.files);
                                uploadedFiles.push(...newFiles);
                                
                                // Atualiza o input com TODOS os ficheiros
                                const dataTransfer = new DataTransfer();
                                uploadedFiles.forEach(file => dataTransfer.items.add(file));
                                fileInput.files = dataTransfer.files;
                                
                                renderCarousel();
                            }
                        });
                    }

                    

