it: assets
	docker buildx bake -f docker-bake.hcl --load dev

assets: \
	rootfs/usr/share/webapps/cgit/cgit-dark.css \
	rootfs/usr/share/webapps/cgit/source-code-pro

rootfs/usr/share/webapps/cgit/cgit-dark.css:
	@curl -L -o "$@" "https://git.zx2c4.com/cgit.css"

source-code-pro := https://git.zx2c4.com/source-code-pro
font-variant := ExtraLight ExtraLightIt Light LightIt Regular It Medium MediumIt Semibold SemiboldIt Bold BoldIt Black BlackIt
rootfs/usr/share/webapps/cgit/source-code-pro:
	@mkdir -p "$@" "$@/EOT" "$@/WOFF2/TTF" "$@/WOFF/OTF" "$@/OTF" "$@/TTF"
	@echo Fetching "$(source-code-pro)/source-code-pro.css"
	@curl -L -o "$@/source-code-pro.css" "$(source-code-pro)/source-code-pro.css"
	@$(foreach variant, $(font-variant), \
		echo Fetching "$(source-code-pro)/EOT/SourceCodePro-$(variant).eot"; \
		curl -L -o "$@/EOT/SourceCodePro-$(variant).eot" "$(source-code-pro)/EOT/SourceCodePro-$(variant).eot"; \
	)
	@$(foreach variant, $(font-variant), \
		echo Fetching "$(source-code-pro)/WOFF2/TTF/SourceCodePro-$(variant).ttf.woff2"; \
		curl -L -o "$@/WOFF2/TTF/SourceCodePro-$(variant).ttf.woff2" "$(source-code-pro)/WOFF2/TTF/SourceCodePro-$(variant).ttf.woff2"; \
	)
	@$(foreach variant, $(font-variant), \
		echo Fetching "$(source-code-pro)/WOFF/OTF/SourceCodePro-$(variant).otf.woff"; \
		curl -L -o "$@/WOFF/OTF/SourceCodePro-$(variant).otf.woff" "$(source-code-pro)/WOFF/OTF/SourceCodePro-$(variant).otf.woff"; \
	)
	@$(foreach variant, $(font-variant), \
		echo Fetching "$(source-code-pro)/OTF/SourceCodePro-$(variant).otf"; \
		curl -L -o "$@/OTF/SourceCodePro-$(variant).otf" "$(source-code-pro)/OTF/SourceCodePro-$(variant).otf"; \
	)
	@$(foreach variant, $(font-variant), \
		echo Fetching "$(source-code-pro)/TTF/SourceCodePro-$(variant).ttf"; \
		curl -L -o "$@/TTF/SourceCodePro-$(variant).ttf" "$(source-code-pro)/TTF/SourceCodePro-$(variant).ttf"; \
	)
