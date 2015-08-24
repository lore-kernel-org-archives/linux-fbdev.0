From: Afzal Mohammed <afzal.mohd.ma@gmail.com>
Date: Mon, 24 Aug 2015 13:53:48 +0000
Subject: Re: [RFC] fbdev/riva:change to use generice function to implement reverse_order()
Message-Id: <20150824134148.GA3394@afzalpc>
List-Id: <linux-fbdev.vger.kernel.org>
References: <C21B8761-0447-45A6-B833-742E3B4C13DE@gmail.com>
 <55D5B3A9.6040901@ti.com>
 <867D66CD-9A3B-4536-B537-8C065C85E497@gmail.com>
 <55D6C812.6080400@ti.com>
 <4DCC50F3-9B6D-4A3A-9693-E7A7196564A8@gmail.com>
 <55D6DAE5.20304@ti.com>
 <20150822075310.GA2337@afzalpc>
 <F9B74F97-EF3F-4051-B54B-B6CDD2946374@gmail.com>
In-Reply-To: <F9B74F97-EF3F-4051-B54B-B6CDD2946374@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yalin wang <yalin.wang2010@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, adaplas@gmail.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

Hi,

On Mon, Aug 24, 2015 at 04:31:13PM +0800, yalin wang wrote:
> 
> i only submit the bit reverse patch for arm / arm64 arch,

yes, saw later git blaming it on you :)

> > Not for this case, but once measured on ARM, iirc, a 32-bit asm bit
> > reversal as compared to doing it in C was taking 1 cycle as opposed to
> > ~225 cycles!, of course writing optimized C could have made it fare
> > better, but still would reach no-way near asm bit reversal.

The above measurement was done not in Linux, rather on a baremetal
code, but seeing the efficient Kernel C implementation, realized that
the gain would not be that much, it would be good to know if there are
measurements for Kernel bitreversal in C & asm (on supported arch)

Regards
afzal
