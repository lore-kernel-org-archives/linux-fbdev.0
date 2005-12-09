From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Re: [PATCH 1/1 2.6.15-rc4-git1] Fix switching
 to KD_TEXT
Date: Fri, 09 Dec 2005 21:35:59 +0100
Message-ID: <4399EAAF.2020406@t-online.de>
References: <4398B888.50005@t-online.de> <4398CEAF.9050303@gmail.com> <43997037.4020206@t-online.de> <20051209141401.GA2724@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkoxS-0004Wp-1k
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 12:35:10 -0800
Received: from mailout01.sul.t-online.com ([194.25.134.80])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkoxQ-0002fg-G9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 12:35:10 -0800
In-Reply-To: <20051209141401.GA2724@sci.fi>
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

Ville Syrj=E4l=E4 schrieb:

>However if you're really going to add more uneccessary set_par() calls=20
>please make them configurable (eg. CONFIG_BROKEN_X). I'll go crazy if my=
=20
>CRT is going to start resyncing on every vt switch.
>
> =20
>
What about a flag HW_NEEDS_EARLY_SETPAR?
I think I will all something like this tomorrow.

cu,
 Knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
