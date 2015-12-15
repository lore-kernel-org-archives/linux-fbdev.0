From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Dec 2015 16:46:44 +0000
Subject: Re: [PATCH v2] ARM: multi_v7_defconfig: Enable some drivers for LS1021A
Message-Id: <4261942.cfn90bpvGM@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449650499-28660-1-git-send-email-b18965@freescale.com>
In-Reply-To: <1449650499-28660-1-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 09 December 2015 16:41:39 Alison Wang wrote:
> This patch enables some drivers for LS1021A, such as
> GIANFAR, WATCHDOG, AUDIO, QSPI, I2C, ESDHC, EDMA, FTM.
> QorIQ Clock Framework and Ramdisk support is also enabled.
> 
> Signed-off-by: Alison Wang <alison.wang@freescale.com>
> 

Applied to next/defconfig, thanks!

	Arnd
