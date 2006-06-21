From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: porting fb driver to 2, 6(fb_get_fix,
	fb_get_var)
Date: Wed, 21 Jun 2006 16:41:48 +0800
Message-ID: <4499064C.1010507@gmail.com>
References: <20060621073724.59709.qmail@web37901.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsyHk-0005qD-KT for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 01:42:04 -0700
Received: from wx-out-0102.google.com ([66.249.82.199])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FsyHi-0004Cr-Va
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 01:42:04 -0700
Received: by wx-out-0102.google.com with SMTP id t4so88258wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Jun 2006 01:42:02 -0700 (PDT)
In-Reply-To: <20060621073724.59709.qmail@web37901.mail.mud.yahoo.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, syed khader <sk.syed@yahoo.com>

syed khader wrote:
> 
> --- "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> syed khader wrote:
>>> --- "Antonino A. Daplas" <adaplas@gmail.com>
>> wrote:
>>>> syed khader wrote:
>>
> Thanks for the inputs. Written as per your
> suggestions. I still have these questions:
> 1) The 2.4 driver code had fb_ioctl defined,
> apparently there is a user space application which
> uses these ioctls.(Basically these ioctls are used to
> set X and Y fontsizes and print at x and y
> coordinates)

If the 2.4 driver an xxxfb_ioctl() hook, then yes, you
can retain them practically unchanged.

(Just curious about the description of the ioctl, I don't
think you will need them for 2.6 as the driver should have
no concept of fontsizes)

> Shall I retain these ioctl OR does 2.6
> framebuffer has a different mechanism to do this?

You can retain driver-specific ioctls.

> 2) How can I know whether generic versions
> (cfb_imageblit & cfb_fillrect) will be sufficient OR  
> I should write specific to my LCD hardware.

If the framebuffer supports packed-pixel formats, then the
cfb_* drawing functions are sufficient.

In 2.4, if your driver is linked to fbcon-cfb*.c, then
you should be fine using the generic functions.

Tony
