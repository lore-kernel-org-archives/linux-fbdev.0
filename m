From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: [PATCH 1/1 2.6.15-rc4-git1] Fix switching to KD_TEXT
Date: Fri, 9 Dec 2005 16:14:01 +0200
Message-ID: <20051209141401.GA2724@sci.fi>
References: <4398B888.50005@t-online.de> <4398CEAF.9050303@gmail.com> <43997037.4020206@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ekj0o-00049b-Gl
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 06:14:14 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ekj0j-00087j-18
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 06:14:14 -0800
Content-Disposition: inline
In-Reply-To: <43997037.4020206@t-online.de>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Fri, Dec 09, 2005 at 12:53:27PM +0100, Knut Petersen wrote:
> And please don=B4t argue that X or certain releases are broken. That is=
=20
> true, but ordinary
> users will use those broken versions for years.

Then they should just keep using vgacon.

However if you're really going to add more uneccessary set_par() calls=20
please make them configurable (eg. CONFIG_BROKEN_X). I'll go crazy if my=20
CRT is going to start resyncing on every vt switch.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
