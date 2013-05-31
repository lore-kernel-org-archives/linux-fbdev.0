From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2013 13:38:08 +0000
Subject: Re: [PATCH v3 6/8] video: xilinxfb: Add support for little endian accesses
Message-Id: <1991235.Da6plQRqqE@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370004925.git.michal.simek@xilinx.com> <c1791574b211528b9f59af634018b7c83678f963.1370004925.git.michal.simek@xilinx.com>
In-Reply-To: <c1791574b211528b9f59af634018b7c83678f963.1370004925.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Timur Tabi <timur@tabi.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On Friday 31 May 2013 14:55:36 Michal Simek wrote:
> Dynamically detect endianess on IP and use
> ioread/iowrite functions instead of powerpc and microblaze
> specific out_be32.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
