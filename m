From: Ani Joshi <ajoshi@unixbox.com>
Subject: Re: is it possible to set a picture as background
 with the framebuffer ?
Date: Sun, 11 Aug 2002 15:47:56 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0208111542430.98970-100000@shell.unixbox.com>
References: <20020811173130.GA4151@stargate.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from shell.unixbox.com ([207.211.45.65])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17e1JG-000706-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 11 Aug 2002 15:35:42 -0700
In-Reply-To: <20020811173130.GA4151@stargate.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Linux Frame Buffer Devel Mailing List <linux-fbdev-devel@lists.sourceforge.net>


Yes, this is possible.  A while back I did this as an exercise of
a video card.  There are several ways to do this, kernel, userland, etc,
but probably easiest is to load a bitmap in the kernel.

If you feel like going one step further, you can do what I did and add
alpha blending for the text console over your image.  Doing
graphics-on-graphics alpha blending is quite expensive so it is probably a
good idea to expose this feature of your video card, however getting the
documentation for your particular card will be a chore.

This ofcourse is just a for-fun thing, and one would never expect such a
feature in the kernel.  A properly designed userland app would best fit
this.


ani

On Sun, 11 Aug 2002, Stephane Wirtel wrote:

> dear,
>
> is it possible to set a picture as background with the framebuffer ?
> i'm searching about all possibilities with the FrameBuffer.
>
> --
> Stephane Wirtel <stephane.wirtel@belgacom.net>
> Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
