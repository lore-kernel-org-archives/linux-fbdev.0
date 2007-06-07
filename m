From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: PXA270 framebuffer
Date: Thu, 07 Jun 2007 21:52:13 +0800
Message-ID: <1181224333.4502.20.camel@daplas>
References: <BAY112-F36C82E4DE08DC1A472621A83260@phx.gbl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwIPw-0004Wc-EM for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 06:52:48 -0700
Received: from wa-out-1112.google.com ([209.85.146.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HwIPv-0003ty-VN
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 06:52:48 -0700
Received: by wa-out-1112.google.com with SMTP id k22so617314waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 07 Jun 2007 06:52:47 -0700 (PDT)
In-Reply-To: <BAY112-F36C82E4DE08DC1A472621A83260@phx.gbl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Julien Lebot <lesnip3r@hotmail.com>

On Thu, 2007-06-07 at 15:22 +0400, Julien Lebot wrote:
> Hi,
> 
> I'm currently developping on the Gumstix verdex platform and I noticed that 
> the PXA270 processor includes a support for smartpanel screen in its 
> framebuffer.
> 
> I've already written a small "driver" which is just a prototype to test if 
> the LCD panel was working but it's far from being something really useful. 
> (display only a picture, call some hardware functions of the LCD (rotate 
> ...) and exit)
> Also it's not using the PXA270 framebuffer at all, the communication 
> protocol is handled in software which is pretty slow (about 1sec to display 
> the picture).
> 
> Since the PXA270 uses the pxafb driver I wonder is there is any plan to add 
> the support for smart panels.
> I thought about modifying the driver so that parameters can be passed at 
> boot time specifying if it is a smart-panel or a "regular" LCD along with 
> other video parameters.
> In the driver I understand that it is needed to set up the framebuffer 
> registers, then enabling the framebuffer and passing the data/command 
> through the DMA channel 6 using some kind of scheduling function.
> Well so far all my attempts did not lead to something viable :D
> 
> I've also tried to write a framebuffer driver from vfb and fbskeleton for 
> this kind of screen but I'm a real newbie at kernel programming, thus 
> leading to nothing at the moment.
> I've posted on the linux-kernel mailing list and got some useful answers 
> about kernel programming and the framebuffer itself, though I think this 
> mailing list is more appropriate.
> 
> Any idea / help would be really appreciated,

You may want to look at arcfb.c.  If you look at it's copyarea, fillrect
and imageblit functions, they use the generic drawing functions, then
immediately followed by an arcfb_lcd_update(). That's where the contents
of the framebuffer is transferred to the internal memory of the LCD. 

The same is done for arcfb_write().

(You may want to do this step first.)

The above method make the framebuffer console work. Writing to /dev/fb0
will also work (cat "file" > /dev/fb0). However, for applications that
uses mmap(), such as X, it will not work.  You have to do some VM magic
to make mmap() function for your driver. For this functionality, look at
hecubafb.c driver and fb_defio.c. hecubafb.c and fb_defio.c is new for
2.6.21.

(This is the second step to make your smart lcd fully functional.)

Tony
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
