From: "Linux  PPC" <linuxppc@rediffmail.com>
Subject: Re: Re: bits_per_pixel query
Date: 11 Sep 2002 12:37:18 -0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020911123718.28335.qmail@webmail26.rediffmail.com>
Reply-To: "Linux  PPC" <linuxppc@rediffmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [202.54.124.130] (helo=webmail26.rediffmail.com)
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17p6kt-0006o9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Sep 2002 05:38:04 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain;
	format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 09 Sep 2002 Antonino Daplas wrote :
>Just pad the pitch/line_length/stride of the buffer to the next 
>byte
>alignment your hardware is capable of.  It is acceptable to have 
>excess
>bits/bytes which theoretically your hardware will ignore.

The padding is at the end of the line_length, or
at the end of the pixel data? I tried both ways,
but I'm getting a skewed square, which I draw
using a user space application.

>For static pseudocolor and truecolor, that is true, since 0 is 
>hardwired
>to black.  For pseudocolor and directcolor, that depends on how 
>the
>DAC/palette is loaded. In most cases, it will produce a black 
>screen.

For psuedocolor and direct color, does the pixel
data, have the index into the colormap or does it
have actual colors? If it has the index, then the size of the 
buffer would be lesser: right?

Thanks,

- navin.

__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/



-------------------------------------------------------
In remembrance
www.osdn.com/911/
