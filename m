From: joachim.henke@stud.tu-ilmenau.de
Subject: Re: 3DFX framebuffer driver v0.2.2
Date: Thu, 24 Apr 2003 09:28:53 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3EA7A045.5040509@stud.tu-ilmenau.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 198d1R-0007FB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 24 Apr 2003 02:28:05 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net

The URL doesn't work anymore. Get the patch from here:
http://www.stud.tu-ilmenau.de/~johe-ii/3dfx-0.2.2-2.4.20.diff.gz

James Simmons wrote:
>>The current kernel still contains version 0.1.3 which is rather old. Much
>>work has been done until version 0.2.2, mainly support for:
>>
>>* non-8 dot wide fonts
>>* multihead
>>* full 8/16/24/32 bit color (fixes the ugly bootup penguin)
>>* MIPS
>>* module options
>>
>>I think it's worth to give it a chance and to continue development on the
>>base of that code. So I "ported" it to kernel 2.4.2x. Get this new patch
>>here:
>>
>>http://tu-ilmenau.de/~johe-ii/3dfx-0.2.2-2.4.21-pre1.diff.gz
>>
>>I just merged the improvements that happened to v0.1.3 while it was in the
>>kernel and did some source formating.
> 
> 
> Thanks. I'm looking over the patch now and will intergrate it into 2.5.X



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
