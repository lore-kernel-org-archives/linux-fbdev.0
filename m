From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 21 Aug 2017 14:04:14 +0000
Subject: Re: [PATCH 1/2] video: fbdev: Fix multiple style issues in xilinxfb
Message-Id: <2014067.suSortcy05@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170808081042epcas4p3b6787c3895bec41cb37aa4ae868adb45@epcas4p3.samsung.com>
 <b07b143769ed5dccf44e9de4cb0d5c6203b3eca0.1502179820.git.michal.simek@xilinx.com>
In-Reply-To: <b07b143769ed5dccf44e9de4cb0d5c6203b3eca0.1502179820.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday, August 08, 2017 10:10:25 AM Michal Simek wrote:
> From: Hyun Kwon <hyun.kwon@xilinx.com>
> 
> All reported by from checkpatch
> ./scripts/checkpatch.pl --max-line-length 120 -strict -f
> drivers/video/fbdev/xilinxfb.c
> 
> WARNING: Block comments should align the * on each line
> WARNING: Block comments use a trailing */ on a separate line
> WARNING: Block comments use * on subsequent lines
> WARNING: please, no space before tabs
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: Missing a blank line after declarations
> WARNING: struct of_device_id should normally be const
> CHECK: Please don't use multiple blank lines
> CHECK: Blank lines aren't necessary after an open brace '{'
> CHECK: Alignment should match open parenthesis
> CHECK: 'Endianess' may be misspelled - perhaps 'Endianness'?
> CHECK: spaces preferred around that '*' (ctx:VxV)
> ERROR: that open brace { should be on the previous line
> 
> Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Patch queued for 4.14, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

