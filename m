From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:39:52 +0000
Subject: Re: [PATCH] atyfb: fix debugging printks
Message-Id: <20181008103954eucas1p1da3f7c5214c5cfadb018ea3018bb8c52~bm-nC5spE2557925579eucas1p1Q@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180817192650epcas3p30700868aab84614cfcc0cea8a746f106@epcas3p3.samsung.com>
 <alpine.LRH.2.02.1808171525200.31883@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808171525200.31883@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


On 08/17/2018 09:26 PM, Mikulas Patocka wrote:
> This patch fixes the debugging printks. Use pr_cont, so that the lines are
> not broken up. Use printk when starting a new line (a long string of
> pr_cont's without any printks causes missing characters in the console
> output on sparc).
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
