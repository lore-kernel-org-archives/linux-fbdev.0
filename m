From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Advice sought on approach.
Date: 05 Mar 2003 14:40:01 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046875200.10894.216.camel@cambridge.braddahead>
References: <1046867855.2505.200.camel@cambridge.braddahead>
	 <1046870757.1229.94.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from nimbus19.internetters.co.uk ([209.61.216.65])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qa42-00064l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 06:40:10 -0800
In-Reply-To: <1046870757.1229.94.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 13:26, Antonino Daplas wrote:
> On Wed, 2003-03-05 at 20:37, Alex Bennee wrote:
> > Having read the fb-dev docs on www.linux-fbdev.org I'm a little confused
> > as to what actually puts data into the framebuffer. Most of the
> > framebuffer drivers just seem to deal with resolution and colourmap
> > settings. Is this a case of having to re-implement the fbcon drivers as
> > well to get what I want?
> The pixels placed to the framebuffer are all done in the fbcon-cfb*.c
> modules (if you use the generic functions).  This is for standard
> character drawing.  The logo is drawn indepently (fbcon_show_logo in
> fbcon.c).  User applications write directly to the framebuffer via the
> mmap() function.

I think I understand now. When the fb_set_disp function is called I fill
in the display struction with the console display operations. I've got
two choices now:

1. Create a new fbcon_cfb16 file which notes the changed areas before
calling the generic function.

2. Patch the current fbcon_cfb16 (with a CONFIG option) to add the
change tracking facility in a more generic way.

I guess the question is is it worth doing 2 as a potential upstream
patch? Or is this sort of thing so specialised I should just keep it all
packed in my own fb driver?

I guess I can't easily implement user access via mmap without uploading
the entire screen, which I'm not intending to do anyway because all I
really need is the console support - at least for now.

> > Are there any examples of drivers that have a similar architecture that
> > would be worth looking at? I've had a look at the vfb.c code but again
> > that seems too simplistic compared to what I'll need.
> 
> Search the archives for SED1335.  The author implemented a shadowed
> virtual framebuffer using system memory.  The contents of the virtual
> framebuffer are written to the data port periodically via a timer
> function.

I couldn't find anything in the mail archives but after some careful
googling I found this site (posted for reference):
ftp://ssv-embedded.de/ssv/products/trm916/sample/x86/linux/fbdev which
seems to be the one your refering to.

Thanks for the pointer, seeing the code made things a lot clearer :-)

-- 
Alex, homepage: http://www.bennee.com/~alex/

Bennett's Laws of Horticulture:
	(1) Houses are for people to live in.
	(2) Gardens are for plants to live in.
	(3) There is no such thing as a houseplant.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
