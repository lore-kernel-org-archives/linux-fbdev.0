From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: "remap_page_range" i810 compile time problem ..
Date: Wed, 9 Mar 2005 16:44:13 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348113A4887@mail.esn.co.in>
Reply-To: linux-fbdev-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: linux-fbdev-users-admin@lists.sourceforge.net
Errors-To: linux-fbdev-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-users@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-users>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-users@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net


Hi all,

I have problem with compiling the i810fb driver downloaded from
Sourceforge site.
I have D/W the i810fb patch "linux-i810fb-0.0.35.tar.bz2".

When I run the make modules I get the following error

i810_main.c: 643: warning: passing arg 1 of 'remap_page_range_R2baf18f2'
makes pointer from integer without a cast
i810_main.c: 643: incompatible type for argument 4 of
'remap_page_range_R2baf18f2'
i810_main.c: 643: too few arguments to function
'remap_page_range_R2baf18f2'
Make[3]: *** [I810_main.c] Error 1
........
......

The call to "remap_page_range()" is as follows:-

return (io_remap_page_range(vma->vm_start, off, vma->vm_end -
vma->vm_start, vma->vm_page_prot)) ? -EAGAIN : 0;

I am running Redhat 9 Linux.

Regards,
Mukund jampala




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
