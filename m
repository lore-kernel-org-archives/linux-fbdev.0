From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: fbcon=map:... broke with 2.6.7 -> 2.6.9-rc3 transition
Date: Wed, 6 Oct 2004 13:03:10 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041006100310.GA14889@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CF8dm-0001Lg-0P
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Oct 2004 03:03:22 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CF8di-00031f-Mb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Oct 2004 03:03:21 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 5CECD255A7
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  6 Oct 2004 13:03:11 +0300 (EEST)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

I just upgraded from 2.6.7 to 2.6.9-rc3 and the fbcon=3Dmap:... option=20
stopped working.

My system has two matrox cards with /dev/fb1 being the head I want to use=
.=20
So I boot with fbcon=3Dmap:111111. With 2.6.9-rc3 all I could see was=20
some garbage and I had to log in via network to run con2fb manually. I=20
don't have a monitor attached to the other card so I'm not sure if the=20
output went there.

I seem to recall some patches from Tony regarding fbcon options. Were=20
those applied to 2.6.9-rc3?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
