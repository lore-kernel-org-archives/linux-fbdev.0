From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Sat, 08 Mar 2003 15:20:36 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E69FC34.50703@winischhofer.net>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80	 80506@winischhofer.net> <1047045694.1310.6.camel@localhost.localdomain>	<3E68B895.2080500@winischhofer.net>	<1047067923.1226.26.camel@localhost.localdomain> 	<3E69065D.3090706@winischhofer.net> 	<1047084988.2388.4.camel@localhost.localdomain> <1047101983.1231.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rfAv-00083O-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 08 Mar 2003 06:19:46 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



Continued:  What happens with your solution of the virtual area is only 
1.5 times the size of the visible area? Did your check this?

 >> 	p->vrows = info->var.yres_virtual / vc->vc_font.height;
 >>+	p->vrows -= info->var.yres/vc->vc_font.height - vc->vc_rows;

yres = 768
yres_virtual = 1152
fontheight= 16
rows = 48

vrows = 1152 / 16 = 72
72 - (768 / 16) - 48 = -24

:) Any question?

Thomas


Antonino Daplas wrote:
> On Sat, 2003-03-08 at 08:58, Antonino Daplas wrote:
> 
>>On Sat, 2003-03-08 at 04:51, Thomas Winischhofer wrote:
>>
>>>I don't see why this is simpler, but I do see it wastes a lot of screen 
>>>space :)
>>>
>>
>>yep, it'a a typo.
>>
>>Tony
>>
>>diff -Naur linux-2.5.64-fbdev/drivers/video/console/fbcon.c linux-2.5.64/drivers/video/console/fbcon.c
>>--- linux-2.5.64-fbdev/drivers/video/console/fbcon.c	2003-03-07 15:03:06.000000000 +0000
>>+++ linux-2.5.64/drivers/video/console/fbcon.c	2003-03-08 00:49:09.000000000 +0000
>>@@ -1044,6 +1044,7 @@
>> 		vc->vc_rows = nr_rows;
>> 	}
>> 	p->vrows = info->var.yres_virtual / vc->vc_font.height;
>>+	p->vrows -= info->var.yres/h - vc->vc_rows;
> 
>                     ^^^^^^^^^^^^^^^^
> 
> I also meant info->var.yres/vc->vc_font.height :-)
> 
> Tony
> 
> 
> 


-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
