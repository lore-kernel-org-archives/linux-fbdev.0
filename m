From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 1/9] viafb: VIA Frame Buffer Device
	Driver - Resend
Date: Thu, 8 May 2008 08:58:31 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67855@exchtp03.taipei.via.com.tw>
References: <20080507140357.9320dfcd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0776010845=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtuT0-0005J1-0C for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 17:58:38 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtuSy-0002U0-J5
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 17:58:38 -0700
Content-class: urn:content-classes:message
In-Reply-To: <20080507140357.9320dfcd.akpm@linux-foundation.org>
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
To: akpm@linux-foundation.org, krzysztof.h1@poczta.fm
Cc: linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org, linux-kernel@vger.kernel.org

--===============0776010845==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="Big5"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks a lot.
I will check the the scripts/checkpatch.pl after the codes are modified. =


About the subject, that's my carelessness and I will correct them by =
your recommendation next time.

In addition, should I resend the patches after they are modified? =
Thanks.

BRs,
Joseph Chan=20

-----Original Message-----
From: Andrew Morton [mailto:akpm@linux-foundation.org]=20
Sent: Thursday, May 08, 2008 5:04 AM
To: Krzysztof Helt
Cc: Joseph Chan; geert@linux-m68k.org; =
linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH 1/9] viafb: VIA Frame Buffer =
Device Driver - Resend

On Wed, 7 May 2008 18:43:33 +0200
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> A general comment is that you use to many global variables.

yes, that was my first impression.  The _names_ of those variables is a =
real problem.  lcd_mode, DeviceStatus, second_size, primary_dev, etc.  =
The driver is attempting to reserve all those names for itself, =
kernel-wide.

So at a minimum, going through and prepending viafb_ onto all those =
would be needed.


There are a number of layout glitches in there.  Such as a strange =
combination of two styles:

void foo(void)
{

versus

void foo(void ) {

Many of these things can be pinpointed by processing the diff with =
scripts/checkpatch.pl.


Administrative note: all nine patches had the same title "viafb: VIA =
Frame Buffer Device Driver".  Please choose unique and meaningful names =
for each patch, such as "viafb: add utility header file".


Apart from those fairly easily-fixed things, the driver looks pretty =
good from a quick scan, given how large it is, and given that it =
probably has been around for quite a long time..



--===============0776010845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0776010845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0776010845==--
