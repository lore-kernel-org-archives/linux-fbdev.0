From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Fw: [Bugme-new] [Bug 3946] New: sis/sis_main.c compilation error
Date: Sun, 26 Dec 2004 14:54:40 +0100
Message-ID: <1104069280.41cec2a0b8820@home.winischhofer.net>
References: <20041225143118.0303ccc3.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CiYsU-0006r4-Bp
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Dec 2004 05:56:10 -0800
Received: from [213.229.38.18] (helo=home.winischhofer.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CiYsS-0005OX-Vu
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Dec 2004 05:56:10 -0800
In-Reply-To: <20041225143118.0303ccc3.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Quoting Andrew Morton <akpm@osdl.org>:

>
>
> Begin forwarded message:
>
> Date: Sat, 25 Dec 2004 10:17:21 -0800
> From: bugme-daemon@osdl.org
> To: bugme-new@lists.osdl.org
> Subject: [Bugme-new] [Bug 3946] New: sis/sis_main.c compilation error
>
>
> http://bugme.osdl.org/show_bug.cgi?id=3946
>
>            Summary: sis/sis_main.c compilation error
>     Kernel Version: 2.6.10
>             Status: NEW
>           Severity: normal
>              Owner: drivers_video-other@kernel-bugs.osdl.org
>          Submitter: public@kurt.hindenburg.name
>
>
> /usr/src/linux-2.6.10)> make
>   CHK     include/linux/version.h
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/asm-i386/asm_offsets.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   CC      drivers/video/sis/sis_main.o
> drivers/video/sis/sis_main.c: In function `sisfb_set_par':
> drivers/video/sis/sis_main.c:1817: error: structure has no member
> named `currcon'
> make[3]: *** [drivers/video/sis/sis_main.o] Error 1
> make[2]: *** [drivers/video/sis] Error 2
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2


Not reproducible.

Thomas

--
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net       http://www.winischhofer.net
mailto:twini@xfree86.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
