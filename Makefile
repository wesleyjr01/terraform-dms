# Global Variables
STACK_NAME=postres-db-stack
AWS_PROFILE=default

create-postgres-db-stack: cloudformation/source_pg_db.yml
	aws cloudformation create-stack \
	--stack-name ${STACK_NAME} \
	--template-body file://cloudformation/source_pg_db.yml \
	--profile ${AWS_PROFILE} \
	--capabilities CAPABILITY_NAMED_IAM

delete-postgres-db-stack: cloudformation/source_pg_db.yml
	aws cloudformation delete-stack \
	--stack-name ${STACK_NAME} \
	--profile ${AWS_PROFILE}