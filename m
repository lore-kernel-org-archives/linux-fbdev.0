From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 0/13 v2] viafb: VIA Frame Buffer
	Device Driver
Date: Mon, 11 Aug 2008 16:03:12 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078B70E3@exchtp03.taipei.via.com.tw>
References: <20080808182704.28bd9fb3.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0987255631=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSSN5-0006L0-BP for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 01:03:19 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSSN3-0000Kb-SJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Aug 2008 01:03:19 -0700
Content-class: urn:content-classes:message
In-Reply-To: <20080808182704.28bd9fb3.krzysztof.h1@poczta.fm>
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
To: krzysztof.h1@poczta.fm
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

--===============0987255631==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks to remind, but after I checked the patches in linux-fbdev-devel =
mailing list.
It seems there is no missing lines as you mentioned.=20

Would you please tell me the detailed problem you met? Thanks.

In addition, if possible, I could send you a file which includes all =
patches.
How do you think that?=20

BRs,
Joseph

-----Original Message-----
From: Krzysztof Helt [mailto:krzysztof.h1@poczta.fm]=20
Sent: Saturday, August 09, 2008 12:27 AM
To: Joseph Chan
Cc: linux-fbdev-devel@lists.sourceforge.net; =
linux-kernel@vger.kernel.org; akpm@linux-foundation.org; =
geert@linux-m68k.org
Subject: Re: [Linux-fbdev-devel] [PATCH 0/13 v2] viafb: VIA Frame Buffer =
Device Driver

On Fri, 8 Aug 2008 18:09:21 +0800
<JosephChan@via.com.tw> wrote:

> Hi all,
>=20
> Here comes the 13 updated patchs for VIA Frame Buffer Device Driver.
> This driver could be used on VIA UniChrome (Pro) and Chrome9 family =
chips.
> All the patches are based on linux kernel 2.6.27-rc2 and they're =
modified by adopting community's feedback.
> I would like to thank all who provided their suggestions for VIAFB by =
mail.
> Any question, please contact me. Thanks.
>=20

Please resend the 3rd patch as it is damaged (missing 3 lines of each =
file).

I am for merging these patches as they are sent now. It allows sending =
fixes to them as incremental patches.

This set builds at least for my configuration (Pentium3 SMP).=20
Unfortunately, I do not have hardware to test. I though about buying one =
of these sexy VIA ITX boards but it is outside my budget now. Anyway, I =
have too many computers according to my spouse.

Kind regards,
Krzysztof


----------------------------------------------------------------------
Tylko dla detektywow! Konkurs na Smaker.pl Kliknij >>> =
http://link.interia.pl/f1eb1



--===============0987255631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0987255631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0987255631==--
