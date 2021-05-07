CUR_DIR = $(CURDIR)

run:
	swift run Feather

env:
	echo 'FEATHER_WORK_DIR="$(CUR_DIR)/"' > .env.development
	echo 'FEATHER_HTTPS=false' >> .env.development
	
env.testing:
	echo 'FEATHER_WORK_DIR="$(CUR_DIR)/"' > .env.testing
	echo 'FEATHER_HTTPS=false' >> .env.testing

	
clean:
	rm -rf ./Resources/ ./Public/

test:
	swift test
