From: Sven Luther <luther@lambda.u-strasbg.fr>
Subject: Re: pm3fb driver is ok in 2.5.24
Date: Tue, 2 Jul 2002 08:33:14 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020702063314.GA30388@lambda.u-strasbg.fr>
References: <20020701073516.GA26755@lambda.u-strasbg.fr> <3D200B7D.7436FF5F@irisa.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dpt-info.u-strasbg.fr ([130.79.44.193])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17PH4l-0001P6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Jul 2002 23:23:48 -0700
Content-Disposition: inline
In-Reply-To: <3D200B7D.7436FF5F@irisa.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: Romain Dolbeau <dolbeau@irisa.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2002 at 09:57:49AM +0200, Romain Dolbeau wrote:
> Sven Luther wrote:
> 
> > I have compiled a 2.5.24 kernel and added the few things needed to make
> > the pm3fb work (basically, i had to patch Config.in and Config.help so i
> > could enable it in the configuration process).
> 
> Could you send me the patch please ?

Ok, but they are triviel (attached here ...)

> > Is there a reason why it was not enabled previously, or is it just
> > forgetting the these two files (which probably did not patch correctly
> > due to the Config.in and Config.help location and format change).
> 
> I though the old-format drivers wouldn't work so I never bothered
> submitting for inclusion.

:)))

> > Anyway, it works fine (well as good as with the 2.4.x kernel), there
> > still is problem with the copying of the text console data at bootup,
> > but apart from that everything is fine.
> > 
> > Should i send over a patch for adding it to the Config.xxx files ?
> 
> Please send me the patch, I'll submit them for inclusion

Ok, ...

Friendly,

Sven Luther

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pm3fb.diff"

--- linux-2.5.24/drivers/video/Config.in.orig	Tue Jul  2 08:23:27 2002
+++ linux-2.5.24/drivers/video/Config.in	Tue Jul  2 08:23:09 2002
@@ -22,6 +22,7 @@
 	       bool '    Phase5 CVisionPPC/BVisionPPC support' CONFIG_FB_PM2_CVPPC
 	    fi
 	 fi
+	 tristate '  Permedia3 support (EXPERIMENTAL)' CONFIG_FB_PM3
       fi
    fi
    if [ "$CONFIG_ARM" = "y" ]; then
--- linux-2.5.24/drivers/video/Config.help.orig	Tue Jul  2 08:24:53 2002
+++ linux-2.5.24/drivers/video/Config.help	Tue Jul  2 08:24:30 2002
@@ -68,6 +68,12 @@
   Say Y to enable support for the Amiga Phase 5 CVisionPPC BVisionPPC
   framebuffer cards.  Phase 5 is no longer with us, alas.
 
+CONFIG_FB_PM3
+  This is the frame buffer device driver for the 3DLabs Permedia3
+  chipset, used in Formac ProFormance III, 3DLabs Oxygen VX1 &
+  similar boards, 3DLabs Permedia3 Create!, Appian Jeronimo 2000
+  and maybe other boards.
+
 CONFIG_FB_AMIGA
   This is the frame buffer device driver for the builtin graphics
   chipset found in Amigas.

--zYM0uCDKw75PZbzx--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
