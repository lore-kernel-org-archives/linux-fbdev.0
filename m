From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: BUG: fb_imageblit called before fb_check_var
 and fb_set_par function
Date: Sat, 27 Aug 2005 08:36:36 +0800
Message-ID: <430FB594.9040901@gmail.com>
References: <430DB8E6.8000204@t-online.de> <430DD026.2070303@gmail.com> <430DEAD0.8070403@t-online.de> <430E094A.9030603@gmail.com> <430ED17E.6000504@t-online.de> <430F20D2.4060601@gmail.com> <430F43A7.5000103@t-online.de> <430F4AC2.70403@gmail.com> <430F5D92.4080300@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8ogu-00020w-Tj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Aug 2005 17:37:00 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8ogt-0003Ss-MG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Aug 2005 17:37:01 -0700
Received: by wproxy.gmail.com with SMTP id i13so652063wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 26 Aug 2005 17:36:53 -0700 (PDT)
In-Reply-To: <430F5D92.4080300@t-online.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org, Knut Petersen <Knut_Petersen@t-online.de>

Knut Petersen wrote:
>=20
>> This has been discussed before.  Not all hardware can do a set_par()
>> instantaneously, some may require seconds.  And that will become a=20
>> usability
>> problem. Just imagine switching from one console to another and it tak=
es
>> 5 seconds.
>=20
> That would be unacceptable, agreed. But it=B4s also not really acceptab=
le=20
> to risk to execute a few
> dozend imageblits in redraw_screen() while the hardware might be in an=20
> unusable state.

It doesn't. but it depends what you mean by unusable state. In the
console/fbcon/fbdev subsystem an unusable state can be any of the ff:

	- KD_GRAPHICS mode
	- between coming from KD_GRAPHICS to KD_TEXT and before set_par()
	- graphics device in a suspended state=20

If any the above are true, no drawing functions gets called.

> Checking
> for that situation every imageblit would have a big performance penalty=
.
>=20

Maybe. I've measured this before, you lose something like 3-5%.  Hardly
noticeable in real-world usage. So I would gladly sacrifice a little
performance for stability. Doing a set_par() for each switch, in turn,
will be noticeable and is a great blow to usability.  It really boils dow=
n
to a balance between usability, stability and performance.  Throw in code
readability and maintainability also.

(Note: In the case of a bug in an app that runs as root, I think everyone=
 will
agree that the bug must be fixed in the app, not the kernel.)

(Note 2: Even with those checks in place, the 2.6 framebuffer system is s=
till
faster than 2.4)

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
