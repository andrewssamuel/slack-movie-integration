class MessageFormatter

  def genericMessage(titles)
    titles_array = Array[]
    titles.each do |title|
      year = title["RELEASE_DATE"] if !title["RELEASE_DATE"].nil? && !title["RELEASE_DATE"].empty?
      name = "*"+title["TITLE"].to_s.titleize+"*"
      name += " (" +year + ") " if year
      name += "  * _"+title["RATING"].to_s+"_" if !title["RATING"].empty?
      name += "\n`"+title["DISTRIBUTOR"].to_s.titlecase+"`" if !title["DISTRIBUTOR"].empty?
      name += "\n Producer(s):  _"+title["PRODUCER"].to_s.titlecase+ "_" if !title["PRODUCER"].empty?
      name += "\n Director(s):  _"+title["DIRECTOR"].to_s.titlecase+ "_" if !title["DIRECTOR"].empty?
      name += "\n Talent(s):  _"+title["TALENT"].to_s.titlecase+ "_" if !title["TALENT"].empty?

      if title["DBO"] || title["IBO"] ||  title["TBO"]
        name += "\n Box Office($):"
        name += "   DBO: "  +title["DBO"].to_s.titlecase if title["DBO"] && !title["DBO"].nil?
        name += "   IBO: "+title["IBO"].to_s.titlecase  if title["IBO"] && !title["IBO"].nil?
        name += "   TBO: "+title["TBO"].to_s.titlecase  if title["TBO"] && !title["TBO"].nil?
      end

      name += "\n\n`---------------------------------------------------------------------------`"
      titles_array.push(name)
    end
    help_line = "\n`Please enter '*help' anytime to view available commands`"
    titles_array.push(help_line)
    return titles_array
  end

  def titleMessage(titles)
    titles_array = Array[]
    titles.each do |title|

      year = title["RELEASE_DATE"] if !title["RELEASE_DATE"].nil? && !title["RELEASE_DATE"].empty?
      name = "*"+title["TITLE"].to_s.titleize+"*"
      name += " _(" +year + ")_ " if year
      name += " `"+title["DISTRIBUTOR"].to_s.titlecase+"`" if !title["DISTRIBUTOR"].empty?

      titles_array.push(name)
    end
    help_line = "\n`Please enter '*help' anytime to list available commands`"
    titles_array.push(help_line)
    return titles_array

  end

end