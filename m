From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 23 Apr 2013 18:53:50 +0000
Subject: Re: [PATCH 07/11] fbdev/sa1100fb: use vm_iomap_memory()
Message-Id: <20130423185350.GV14496@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366699018-5439-1-git-send-email-tomi.valkeinen@ti.com> <1366699018-5439-7-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1366699018-5439-7-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 23, 2013 at 09:36:54AM +0300, Tomi Valkeinen wrote:
> Use vm_iomap_memory() instead of [io_]remap_pfn_range().
> vm_iomap_memory() gives us much simpler API to map memory to userspace,
> and reduces possibilities for bugs.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
