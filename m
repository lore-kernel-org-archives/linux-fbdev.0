From: Alan Cox <alan@linux.intel.com>
Date: Thu, 15 Mar 2012 14:47:10 +0000
Subject: Re: [PATCH] gma500: Fix mmap frambuffer
Message-Id: <20120315144710.3d6ce9c5@bob.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120315212816.475b0b18.yuasa@linux-mips.org>
In-Reply-To: <20120315212816.475b0b18.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, 15 Mar 2012 21:28:16 +0900
Yoichi Yuasa <yuasa@linux-mips.org> wrote:

> 
> It cannot map correctly if page fault begins from a intermediate
> address.

Thanks, that explains one very strange bug I've been seeing !
