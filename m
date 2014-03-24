From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 24 Mar 2014 15:54:12 +0000
Subject: Re: [PATCH 14/16] backlight: atmel-pwm-bl: remove obsolete driver
Message-Id: <20140324155412.GA9083@piout.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-15-git-send-email-alexandre.belloni@free-electrons.com>
 <20140319142231.GF20872@samfundet.no>
 <000101cf449f$aa609960$ff21cc20$%han@samsung.com>
In-Reply-To: <000101cf449f$aa609960$ff21cc20$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 21/03/2014 at 09:51:16 +0900, Jingoo Han wrote :
> On Wednesday, March 19, 2014 11:23 PM, Hans-Christian Egtvedt wrote:
> > Around Wed 19 Mar 2014 14:03:27 +0100 or thereabout, Alexandre Belloni wrote:
> > > The atmel-pwm-bl driver is now obsolete. It is not used by any mainlined boards
> > > and is replaced by the generic pwm_bl with the pawm-atmel driver using the
> > > generic PWM framework.
> > >
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > 
> > Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 

You didn't comment on patch 08/16, are you fine with it ? I guess this
is the only one holding back the full series.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
