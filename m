From: Wang YanQing <udknight@gmail.com>
Date: Thu, 06 Mar 2014 10:33:50 +0000
Subject: Re: [PATCH] video: fbdev: uvesafb: use CONFIG_X86_PAE surround _PAGE_NX check code
Message-Id: <20140306103349.GA11701@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140305161611.GA32461@udknight>
 <53184655.2090106@ti.com>
In-Reply-To: <53184655.2090106@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: plagnioj@jcrosoft.com, fengguang.wu@intel.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 06, 2014 at 11:56:37AM +0200, Tomi Valkeinen wrote:
> I don't like this, I think this makes the code more messy, just to avoid
> that warning.
> 
> And it might even be buggy. For your patch to work correctly, you need
> to know the internals of _PAGE_NX, i.e. that when CONFIG_X86_PAE is not
> defined, _PAGE_NX is 0. But the driver should not depend on things like
> that. If _PAGE_NX is changed later, the driver will not work correctly.
> 

Very right! Thanks.




