From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [PATCH 6/6] Cell: Draw SPE
	helper penguin logos
Date: Wed, 31 Jan 2007 02:15:39 +0100
Message-ID: <200701310215.39837.arnd@arndb.de>
References: <Pine.LNX.4.62.0701301854060.2509@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701301902410.2830@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HC44q-0008D4-K3 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 17:15:57 -0800
Received: from moutng.kundenserver.de ([212.227.126.187])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HC44o-00031T-Ll
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 17:15:56 -0800
In-Reply-To: <Pine.LNX.4.62.0701301902410.2830@pademelon.sonytel.be>
Content-Disposition: inline
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
To: cbe-oss-dev@ozlabs.org
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Tuesday 30 January 2007 19:02, Geert Uytterhoeven wrote:
> +#ifdef CONFIG_LOGO
> +=A0=A0=A0=A0=A0=A0=A0if (ret > 0) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0extern const struct linux_l=
ogo logo_spe_clut224;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fb_append_extra_logo(&logo_=
spe_clut224, ret);
> +=A0=A0=A0=A0=A0=A0=A0}
> +#endif

You should not have the #ifdef nor the extern declaration in here.
A better way to do it would be to have in include/linux/linux_logo.h
(or similar):

extern const struct linux_logo logo_spe_clut224;
#ifdef CONFIG_LOGO
extern void fb_append_extra_logo(const struct linux_logo *logo, int n);
#else
static inline void fb_append_extra_logo(const struct linux_logo *logo, int =
n)
{
}
#endif

	Arnd <><

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
