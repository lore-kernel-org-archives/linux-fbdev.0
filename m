From: Timur Tabi <timur@tabi.org>
Date: Fri, 31 May 2013 13:05:26 +0000
Subject: Re: [PATCH v3 1/8] video: xilinxfb: Fix OF probing on little-endian systems
Message-Id: <51A8A016.3000306@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370004925.git.michal.simek@xilinx.com> <0a546c3de84c4650d019274debef0ded9007b36f.1370004925.git.michal.simek@xilinx.com>
In-Reply-To: <0a546c3de84c4650d019274debef0ded9007b36f.1370004925.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On 05/31/2013 07:55 AM, Michal Simek wrote:
> -	p = (u32 *)of_get_property(op->dev.of_node, "xlnx,dcr-splb-slave-if", NULL);
> -	tft_access = p ? *p : 0;
> +	of_property_read_u32(op->dev.of_node, "xlnx,dcr-splb-slave-if",
> +			     &tft_access);

This is okay, but just FYI, you could instead have just used be32_to_cpup().

-- 
Timur Tabi
