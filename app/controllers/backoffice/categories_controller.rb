class Backoffice::CategoriesController < BackOfficeController
  before_action :find_category, except: %i[new create index]

    def index
      @categories = Category.all.order(created_at: :desc)

    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to admin_categories_path
        flash[:notice] = 'Category has been created'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @category.update_attributes(category_params)
        redirect_to admin_categories_path
        flash[:notice] = 'Category has been edited'
      else
        format.html { render :edit }
      end
    end

    def destroy
      @category.destroy
      redirect_to admin_categories_path, notice: 'Category was successfully destroyed.'
    end

    private

    def find_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
