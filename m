From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Date: Wed, 19 Mar 2014 14:21:07 +0000
Subject: Re: [PATCH 13/16] avr32: update defconfig to use the generic PWM framework
Message-Id: <20140319142107.GE20872@samfundet.no>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-14-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1395234209-15546-14-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Around Wed 19 Mar 2014 14:03:26 +0100 or thereabout, Alexandre Belloni wrote:
> Now that all boards have switch to the generic PWM framework, update the
> defconfigs to use it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/configs/atngw100_mrmt_defconfig | 5 +++--
>  arch/avr32/configs/atstk1002_defconfig     | 5 +++--
>  arch/avr32/configs/atstk1003_defconfig     | 5 +++--
>  arch/avr32/configs/atstk1004_defconfig     | 5 +++--
>  arch/avr32/configs/atstk1006_defconfig     | 5 +++--
>  arch/avr32/configs/merisc_defconfig        | 5 +++--
>  6 files changed, 18 insertions(+), 12 deletions(-)

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
