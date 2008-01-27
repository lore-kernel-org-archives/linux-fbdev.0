From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 04/11] ps3fb: Inline macros that are used only once
Date: Sun, 27 Jan 2008 10:34:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801271033540.10193@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080125153107.177014292@vixen.sonytel.be>
	<20080126220133.eb99e5c4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-540867663-1201426448=:10193"
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080126220133.eb99e5c4.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, adaplas@gmail.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-540867663-1201426448=:10193
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Jan 2008, Andrew Morton wrote:
> > On Fri, 25 Jan 2008 16:06:27 +0100 Geert Uytterhoeven <Geert.Uytterho=
even@sonycom.com> wrote:
> > From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> >=20
> > ps3fb: inline the X_OFF(), Y_OFF(), WIDTH(), HEIGHT(), and VP_OFF() m=
acros,
> > as they're used in one place only
>=20
> I think the term "open-code" would be more suitable here.  "inlining" m=
eans
> "make it an inline function".  I'll update the changelog.

You're right. Thanks!

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 =C2=B7 B-1840 Londerzeel =C2=B7 Belg=
ium
VAT BE 0413.825.160 =C2=B7 RPR Brussels
Fortis Bank Zaventem =C2=B7 Swift GEBABEBB08A =C2=B7 IBAN BE3900138235861=
9
---584349381-540867663-1201426448=:10193
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
---584349381-540867663-1201426448=:10193--
