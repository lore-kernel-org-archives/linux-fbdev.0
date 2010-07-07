From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 07 Jul 2010 23:41:48 +0000
Subject: Re: [PATCH v2 16/26] fbdev: Add JZ4740 framebuffer driver
Message-Id: <20100707164148.d2a1f8c4.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
        <1276924111-11158-17-git-send-email-lars@metafoo.de>
        <4C310ACD.6040604@metafoo.de>
In-Reply-To: <4C310ACD.6040604@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org

On Mon, 05 Jul 2010 00:27:25 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Hi Andrew
> 
> v2 of this patch has been around for two weeks without any comments. I've fixed all
> the issues you had with v1. If you this version is ok, an Acked-By would be nice :)

I don't do acks - I already have enough to be blamed for.  I'd merge it
if asked to though.  Although I might whine about inappropriate use of
ENOENT, which means "No such file or directory".

