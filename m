From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and
 updated CyblaFB
Date: Wed, 14 Dec 2005 14:08:57 +0100
Message-ID: <43A01969.6050109@t-online.de>
References: <439EF4CB.8030007@t-online.de> <20051213142054.4fd59226.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmXzb-0003uH-8b
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 06:52:31 -0800
Received: from mailout10.sul.t-online.com ([194.25.134.21])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EmXza-0007L3-SC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Dec 2005 06:52:31 -0800
In-Reply-To: <20051213142054.4fd59226.akpm@osdl.org>
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

Andrew Morton wrote:

>Well yes, but effects on cyblafb are possible!  We'd be putting new and
>un-tested-in-linus's-tree code into the tree at the last minute.
>
>It would hardly be a calamity if we were to merge this into 2.6.15 of
>course, but the principle which you describe ain't right.
> =20
>
I write and maintain cyblafb because vesafb is really too slow on my =20
532 Mhz
system.

All changes to cyblafb fall into the following categories:

    -  code to take advantage of all available video memory and thus to=20
allow
        ywrap scrolling.
    - code to allow vxres > xres and thus to allow xwrap scrolling while
       rotation is set to 1 or 3
    - code that helps in testing the upper framebuffer layers. As far as=20
I know,
       cyblafb is the only driver that can be configured at boot or=20
module load
       time to request image data with 8, 16 or 32 bit image data alignme=
nt.
    - bug fixes

I use the cyblafb framebuffer console for about 80% of my work. Any bug=20
in the first
two categories would be immediately recognized by either a locked PC or=20
display
corruptions, the code of the third category has been seriously tested,=20
and there is also
no real possibility of remaining bugs as these also would be either=20
visible or would
lock the system immediately.

I don=B4t know of any cyblafb user that is running the -mm kernels, so=20
testing the
changes there does conform to principles but does not help much in realit=
y.

>Masking pointers to 32 bits.  Is this driver supposed to be run on 64-bi=
t
>machines?
> =20
>
Never can it be run on anything else but 32 bit machines because this=20
graphics core is
integrated in the VIA VT8601A northbridge. So the cpu is either a VIA C3,
a VIA Eden, a Pentium III or a Celeron. It is planned to add support for=20
closely related
graphics cores, but also those can be run with nothing but 32 bit cpus,=20
starting from the
first pentium. Even if this driver would be compiled into a 64 bit=20
kernel, the
imageblit function never would be executed as the init code never will=20
find the
cyberblade/i1 graphics core in such a system.

Sorry for the whitespace damage.

cu,
 knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
