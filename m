From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: RE: [Linux-fbdev-users] RE: Crosstool for EBD9312..
Date: Wed, 9 Mar 2005 15:53:00 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348113A486A@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
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
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net, linux-fbdev-users@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net
Cc: geert@linux-m68k.org, Michael Burian <dynmail1@gassner-waagen.at>, komal_shah802003@yahoo.com


Hi adalpas,

Thanks for the 810fb info.

I have D/W the i810fb patch "linux-2.4.20-i810fb.diff".
These were some rejects & I found some ".ref" in linux, video & i810
directories when I tried patched it to the kernel tree. I just tried to
see if it works apart form the rejects & make bzImage was successful and
"make modules" command FAILED saying:-

i810_main.c: 643: warning: passing arg 1 of 'remap_page_range_R2baf18f2'
makes pointer from integer without a cast
i810_main.c: 643: incompatible type for argument 4 of
'remap_page_range_R2baf18f2'
i810_main.c: 643: too few arguments to function
'remap_page_range_R2baf18f2'
Make[3]: *** [I810_main.c] Error 1
........
......

I am looking into code, I thought mailing u this will be helpful.
What could be the problem?
I am running redhat 9 Linux.

Regards,
Mukund jampala


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
