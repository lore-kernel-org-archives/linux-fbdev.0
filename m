From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 14/17] ps3av: add quirk database for
	broken monitors
Date: Fri, 12 Oct 2007 16:36:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0710121635050.757@pademelon.sonytel.be>
References: <46FDACBE.8080707@gmail.com>
	<20071003140054.b340fe1f.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0710040943170.4788@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-1619437512-1192199780=:757"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgLct-0001dn-9S for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 07:36:34 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgLcr-0002Fb-Jq
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 07:36:31 -0700
In-Reply-To: <Pine.LNX.4.62.0710040943170.4788@pademelon.sonytel.be>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1619437512-1192199780=:757
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

	Hi Andrew,

On Thu, 4 Oct 2007, Geert Uytterhoeven wrote:
> On Wed, 3 Oct 2007, Andrew Morton wrote:
> > On Sat, 29 Sep 2007 09:39:10 +0800
> > "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> >=20
> > > +static const struct ps3av_monitor_quirk {
> > > +	const char *monitor_name;
> > > +	u32 clear_60, clear_50, clear_vesa;
> > > +} ps3av_monitor_quirks[] =3D {
> > > +	{
> > > +		.monitor_name	=3D "DELL 2007WFP",
> > > +		.clear_60	=3D PS3AV_RESBIT_1920x1080I
> > > +	}, {
> > > +		.monitor_name	=3D "L226WTQ",
> > > +		.clear_60	=3D PS3AV_RESBIT_1920x1080I |
> > > +				  PS3AV_RESBIT_1920x1080P
> > > +	}, {
> > > +		.monitor_name	=3D "SyncMaster",
> > > +		.clear_60	=3D PS3AV_RESBIT_1920x1080I
> > > +	}
> > > +};
> >=20
> > One assumes that the presently-unused clear_50 and clear_vesa will
> > be used at some time in the future...
>=20
> So far I haven't encountered (or been reported) a monitor that needed t=
o clear
> 50 Hz or VESA mode flags. I can comment out/#if 0 out/remove those part=
s if you
> prefer.

I removed those fields. Here's an updated patch:

Subject: ps3av: add quirk database for broken monitors

ps3av: add a quirk database for broken monitors where the `best' advertis=
ed
video mode doesn't work

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
Removed the `clear_50' and `clear_vesa' fields of struct ps3av_monitor_qu=
irk,
as they're currently unused

 drivers/ps3/ps3av.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+)

--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -721,6 +721,41 @@ static void ps3av_monitor_info_dump(cons
 	}
 }
=20
+static const struct ps3av_monitor_quirk {
+	const char *monitor_name;
+	u32 clear_60;
+} ps3av_monitor_quirks[] =3D {
+	{
+		.monitor_name	=3D "DELL 2007WFP",
+		.clear_60	=3D PS3AV_RESBIT_1920x1080I
+	}, {
+		.monitor_name	=3D "L226WTQ",
+		.clear_60	=3D PS3AV_RESBIT_1920x1080I |
+				  PS3AV_RESBIT_1920x1080P
+	}, {
+		.monitor_name	=3D "SyncMaster",
+		.clear_60	=3D PS3AV_RESBIT_1920x1080I
+	}
+};
+
+static void ps3av_fixup_monitor_info(struct ps3av_info_monitor *info)
+{
+	unsigned int i;
+	const struct ps3av_monitor_quirk *quirk;
+
+	for (i =3D 0; i < ARRAY_SIZE(ps3av_monitor_quirks); i++) {
+		quirk =3D &ps3av_monitor_quirks[i];
+		if (!strncmp(info->monitor_name, quirk->monitor_name,
+			     sizeof(info->monitor_name))) {
+			pr_info("%s: Applying quirk for %s\n", __func__,
+				quirk->monitor_name);
+			info->res_60.res_bits &=3D ~quirk->clear_60;
+			info->res_60.native &=3D ~quirk->clear_60;
+			break;
+		}
+	}
+}
+
 static int ps3av_auto_videomode(struct ps3av_pkt_av_get_hw_conf *av_hw_c=
onf,
 				int boot)
 {
@@ -739,6 +774,8 @@ static int ps3av_auto_videomode(struct p
 		ps3av_monitor_info_dump(&monitor_info);
=20
 		info =3D &monitor_info.info;
+		ps3av_fixup_monitor_info(info);
+
 		switch (info->monitor_type) {
 		case PS3AV_MONITOR_TYPE_DVI:
 			dvi =3D PS3AV_MODE_DVI;

With kind regards,
=20
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium
=20
Phone:    +32 (0)2 700 8453=09
Fax:      +32 (0)2 700 8622=09
E-mail:   Geert.Uytterhoeven@sonycom.com=09
Internet: http://www.sony-europe.com/
 =09
Sony Network and Software Technology Center Europe=09
A division of Sony Service Centre (Europe) N.V.=09
Registered office: Technologielaan 7 =C2=B7 B-1840 Londerzeel =C2=B7 Belg=
ium=09
VAT BE 0413.825.160 =C2=B7 RPR Brussels=09
Fortis Bank Zaventem =C2=B7 Swift GEBABEBB08A =C2=B7 IBAN BE3900138235861=
9
---584337861-1619437512-1192199780=:757
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
---584337861-1619437512-1192199780=:757
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-1619437512-1192199780=:757--
