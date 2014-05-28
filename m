From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 28 May 2014 23:35:34 +0000
Subject: Re: [PATCHv2 15/15] misc: atmel_pwm: remove obsolete driver
Message-Id: <20140528233534.GA3580@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1401319218-16772-16-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1401319218-16772-16-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, May 29, 2014 at 01:20:18AM +0200, Alexandre Belloni wrote:
> The misc/atmel_pwm is not used by any mainlined boards and has been replaced by
> the pwm-driver using the generic PWM framework.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

