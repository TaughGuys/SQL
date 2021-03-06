USE [Test]
GO
/****** Object:  UserDefinedFunction [dbo].[mianish]    Script Date: 28/10/2017 18:13:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[mianish] (@a INT)
RETURNS NVARCHAR(10)
WITH RETURNS null ON null input 
AS
BEGIN 
DECLARE @b NVARCHAR(10) 
SELECT @b= CASE @a 
    when 1 then N'մեկ'
	when 2 then N'երկու'
	when 3 then N'երեք'
	when 4 then N'չորս'
	when 5 then N'հինգ'
	when 6 then N'վեց'
	when 7 then N'յոթ'
	when 8 then N'ութ'
	when 9 then N'ինը'
	else null
	END;
	RETURN @b
END;


/****** Object:  UserDefinedFunction [dbo].[tasnavor]    Script Date: 28/10/2017 18:20:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[tasnavor] (@a INT)
RETURNS NVARCHAR(10)
WITH RETURNS null ON null input 
AS
BEGIN 
DECLARE @b NVARCHAR(10) 
SELECT @b= case @a 
    when 1 then N'տաս'
	when 2 then N'քսան'
	when 3 then N'եռեսուն'
	when 4 then N'քառասուն'
	when 5 then N'հիթսուն'
	when 6 then N'վաթսուն'
	when 7 then N'յութանասուն'
	when 8 then N'ութանասուն'
	when 9 then N'իննսուն'
	else null
	END;
	RETURN @b
END;


/****** Object:  UserDefinedFunction [dbo].[eranish]    Script Date: 28/10/2017 18:28:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[eranish] (@tiv INT)
RETURNS NVARCHAR(700)
WITH RETURNS null ON null input 
AS
BEGIN
DECLARE @counter INT 
DECLARE @result NVARCHAR(700)
SET @result =N' '
SET @counter=100
WHILE @counter>1
BEGIN
SET @result = @result +isnull (  (case len(@counter)%3
             when 0 then  case @tiv/@counter 
			                     when 1 then N' հարյուր ' else  dbo.mianish( @tiv/@counter)+N' հարյուր ' end
			 when 2 then case 
			                    when @tiv/@counter=1 and @tiv/(@counter/10) >10 
								then isnull(dbo.tasnavor(@tiv/@counter),'') +N'ն' else isnull(dbo.tasnavor(@tiv/@counter),'') end
			
			 when 1 then  dbo.mianish( @tiv/@counter) 								
								 end), ' ' )
 SET @tiv=@tiv -( @tiv/@counter)*@counter
 SET @counter=@counter/ 10
END
RETURN @result+isnull(dbo.mianish( @tiv/@counter),'')
END


/****** Object:  UserDefinedFunction [dbo].[num_to_word]    Script Date: 28/10/2017 18:34:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[num_to_word] (@tiv BIGINT)
RETURNS NVARCHAR(700)
WITH RETURNS null ON null input 
AS
BEGIN
DECLARE @result NVARCHAR(700)
SET @result=''
WHILE @tiv>0
BEGIN
IF len(@tiv)/10>=1 
      BEGIN
	   SET  @result=@result + dbo.eranish(@tiv/1000000000) +N' միլիարդ '
	   SET @tiv=@tiv-(@tiv/1000000000)*1000000000
      END
ELSE 
      BEGIN
	       IF len(@tiv)/7>=1 
                BEGIN
	            SET  @result=@result + dbo.eranish(@tiv/1000000) +N' միլիոն '
	            SET @tiv=@tiv-(@tiv/1000000)*1000000
                END
	        ELSE
			    BEGIN
				   IF len(@tiv)/4>=1 
                     BEGIN
					       IF @tiv/1000 >1
						      BEGIN
	                          SET  @result=@result + dbo.eranish(@tiv/1000) +N' հազար '
	                          SET @tiv=@tiv-(@tiv/1000)*1000
						      END
						   ELSE
						      BEGIN
							  SET  @result=@result + N' հազար '
	                          SET @tiv=@tiv-(@tiv/1000)*1000
							  END 
                      END
                   ELSE 
				          BEGIN
						   SET  @result=@result + dbo.eranish(@tiv)
						   SET @tiv=0
						  END
				END
	  END
END

RETURN @result

END


--RESULTS
SELECT DBO.num_to_word(999999999999)
ինը հարյուր իննսունինը միլիարդ  ինը հարյուր իննսունինը միլիոն  ինը հարյուր իննսունինը հազար  ինը հարյուր իննսունինը

SELECT DBO.num_to_word(100000000001)
հարյուր  միլիարդ   մեկ