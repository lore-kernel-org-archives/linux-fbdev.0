From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 08 Jul 2010 16:46:54 +0000
Subject: Re: [PATCH v2 16/26] fbdev: Add JZ4740 framebuffer driver
Message-Id: <20100708094654.6fbeefe8.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
        <1276924111-11158-17-git-send-email-lars@metafoo.de>
        <4C310ACD.6040604@metafoo.de>
        <20100707164148.d2a1f8c4.akpm@linux-foundation.org>
        <4C35D264.7080809@metafoo.de>
In-Reply-To: <4C35D264.7080809@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org

On Thu, 08 Jul 2010 15:28:04 +0200 Lars-Peter Clausen <lars@metafoo.de> wrote:

> > Although I might whine about inappropriate use of
> > ENOENT, which means "No such file or directory".
> > 
> 
> That is due to to many bad examples, I guess. Would using ENXIO instead keep
> you from whining?

Sounds a bit better.  It's hardly a huge issue though.
