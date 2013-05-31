From: Timur Tabi <timur@tabi.org>
Date: Fri, 31 May 2013 13:41:48 +0000
Subject: Re: [PATCH v3 7/8] video: xilinxfb: Fix sparse warnings
Message-Id: <51A8A89C.8030404@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370004925.git.michal.simek@xilinx.com> <ea3d6fcbb9f7a00a9cdbd3d0a7a4d3401265ebf0.1370004925.git.michal.simek@xilinx.com> <51A8A4ED.6070104@tabi.org> <51A8A7B1.3040709@monstr.eu>
In-Reply-To: <51A8A7B1.3040709@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On 05/31/2013 08:37 AM, Michal Simek wrote:
> The same is for Microblaze. Driver shares fb_virt for IO memory
> and for allocated memory. The purpose of this driver wasn't
> to change the driver logic just resolved sparse warnings.
> The other way is also wrong.
> I have compiled this driver with ppc toolchain and it should
> remove sparse warnings for PPC.

But it's not I/O memory.  It's regular memory.  __iomem is for
memory-mapped I/O, which is limited to a specific range of memory locations.

If sometimes you use regular memory for the framebuffer, and other times
you use real I/O memory for the framebuffer, then you should have two
different pointers.

-- 
Timur Tabi
