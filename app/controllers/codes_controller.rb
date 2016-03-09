class CodesController < ApplicationController
  before_action :set_code, only: [:show, :edit, :update, :destroy]

  require 'open3'

  # GET /codes
  # GET /codes.json
  def index
    @codes = Code.all
  end

  # GET /codes/1
  # GET /codes/1.json
  def show
  end

  # GET /codes/new
  def new
    @code = Code.new
  end

  # GET /codes/1/edit
  def edit
  end

  # POST /codes
  # POST /codes.json
  # OPTIMIZE --> RAILS_ROOT may need to be : Rails.root or null
  def create
    @code = Code.new(code_params)


    fileout = Tempfile.new ["out", ".mbin"] , "tmp"
    filein = Tempfile.new ["in", ".asm"] , "tmp"
    filein.write("#{@code.assembly_source}")

    filein.flush

    `bin/masmbin #{filein.path} #{fileout.path}`


  #stdin, stdout, stderr = Open3.popen3('bin/masmbin  test/masmbin_test/lex.ms test/masmbin_test/results.ms ')

  #stdin, stdout, stderr = Open3.popen3('bin/mkdir -p test/masmbin_test/parapono2')  #WORKS 
   

    #filein.flush
    fileout.flush

    @code.binary = fileout.read

    @code.save

    filein.close
    fileout.close


    respond_to do |format|
      if @code.save
        format.html { redirect_to @code, notice: 'Code was successfully created.' }
        format.json { render :show, status: :created, location: @code }
      else
        format.html { render :new }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end


    

################################################################################################
# WORKS FIX INPUT
#   	pathin = "tmp/binaries/in.txt"
#	fin = File.open(pathin, "w+") 
#  	fin.write("#{@code.assembly_source}")
	
#	fin.flush


#	pathout = "tmp/binaries/out.txt"
#	fout = File.open(pathout, "w+")



#    stdin, stdout, stderr = Open3.popen3('bin/masmbin test/masmbin_test/lex.ms tmp/binaries/out.txt')  #The Open3.open3 way gives your access to stdin, stdout and stderr.
#	fout.flush

########################################################################################################




    
  end

  # PATCH/PUT /codes/1
  # PATCH/PUT /codes/1.json
  def update
    respond_to do |format|
      if @code.update(code_params)
        format.html { redirect_to @code, notice: 'Code was successfully updated.' }
        format.json { render :show, status: :ok, location: @code }
      else
        format.html { render :edit }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.json
  def destroy
    @code.destroy
    respond_to do |format|
      format.html { redirect_to codes_url, notice: 'Code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code
      @code = Code.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_params
      params.require(:code).permit(:assembly_source, :name, :binary)
    end
end
