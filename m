From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 6/9] viafb: VIA Frame Buffer Device
	Driver
Date: Thu, 8 May 2008 16:00:38 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67EE3@exchtp03.taipei.via.com.tw>
References: <20080508071809.GA11121@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0249036034=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ju13d-0003DC-L6 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 01:00:53 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ju13c-0001vp-5i
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 01:00:53 -0700
Content-class: urn:content-classes:message
In-Reply-To: <20080508071809.GA11121@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: santiago@crfreenet.org
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org

--===============0249036034==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="Big5"
Content-Transfer-Encoding: quoted-printable

Hi Ondrej,

Thanks for your reminding, I will put the configuration file to =
Documentation/fb next time.
As I know, it should contains some other modes. l check with our =
engineers later.

BRs,
Joseph Chan=20

-----Original Message-----
From: Ondrej Zajicek [mailto:santiago@crfreenet.org]=20
Sent: Thursday, May 08, 2008 3:18 PM
To: Joseph Chan
Cc: akpm@linux-foundation.org; geert@linux-m68k.org; =
linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH 6/9] viafb: VIA Frame Buffer =
Device Driver

On Wed, May 07, 2008 at 07:09:42PM +0800, JosephChan@via.com.tw wrote:
> diff -Nur a/drivers/video/via/viafb.modes =
b/drivers/video/via/viafb.modes
> --- a/drivers/video/via/viafb.modes	1969-12-31 19:00:00.000000000 =
-0500
> +++ b/drivers/video/via/viafb.modes	2008-04-29 02:51:27.000000000 =
-0400
> @@ -0,0 +1,870 @@
> +#
> +#
> +#   These data are based on the CRTC parameters in
> +#
> +#       VIA Integration Graphics Chip
> +#       (C) 2004 VIA Technologies Inc.

Configuration file for fbset definitely shouldn't be here between C =
source files. If it is needed, then it should be somewhere in =
Documentation/fb .

BTW, Are these modes common VESA modes (DVT, GTF or CVT)  or some other =
modes. In first case there is probably no reason to include them.

--
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org) OpenPGP =
encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net) "To err =
is human -- to blame it on a computer is even more so."



--===============0249036034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0249036034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0249036034==--
