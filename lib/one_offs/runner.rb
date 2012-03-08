module OneOffs
  class Runner
    class << self
      def run
        Dir.glob(File.join(Dir.pwd, "lib", "one_offs", "*.rb")).sort.each do |one_off|
          execute(one_off)
        end
      end

      private
      def execute(file)
        puts "Running #{one_off}"
        require one_off
        one_off_name = File.basename(one_off, ".rb")
        one_off_class = one_off_name.scan(/\d_(.*)/).to_s.classify
        Object.const_get(one_off_class).send(:process)
      end
    end
  end
end
