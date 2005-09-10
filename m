From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: can't access video memory?
Date: Sat, 10 Sep 2005 11:01:39 -0400
Message-ID: <9e4733910509100801508140b4@mail.gmail.com>
References: <091020051443.548.4322F10400014A8E000002242207020653079A0D00@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EE6rX-0000nJ-Ld
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Sep 2005 08:01:51 -0700
Received: from wproxy.gmail.com ([64.233.184.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EE6rU-0003Vy-Fq
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Sep 2005 08:01:51 -0700
Received: by wproxy.gmail.com with SMTP id i3so1717172wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 10 Sep 2005 08:01:39 -0700 (PDT)
In-Reply-To: <091020051443.548.4322F10400014A8E000002242207020653079A0D00@comcast.net>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, fbui@comcast.net

On 9/10/05, fbui@comcast.net <fbui@comcast.net> wrote:
> > Zack Smith wrote:=20
> > > Does anyone know what might cause this?=20

On x86 the kernel is limited to 1GB of virtual address space. So
physical memory plus mapped video needs to total less than 1GB for
best performance.

Systems with 1GB of RAM or more want to minimize mapped VRAM. Anything
that is mapped over the minimum pushes kernel data structures out of
normal access and into highmem access which is significantly slower.
For example mapping a 512MB video card on a 1GB system knocks about
10% off from your system performance since it pushes 512MB of RAM into
highmem access mode.

The drivers aren't smart enough to look for less than 1GB of physical
memory and expand their mapped areas.

None of this applies from user space. There are no problems with
mapping the full card.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
