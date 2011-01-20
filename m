From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Thu, 20 Jan 2011 19:42:16 +0000
Subject: Re: Request for unicore32 architecture codes to merge into
Message-Id: <20110120114216.4b23182a@jbarnes-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <004901cbb4d5$b9bb1370$2d313a50$@mprc.pku.edu.cn>
In-Reply-To: <004901cbb4d5$b9bb1370$2d313a50$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: sfr@canb.auug.org.au, Arnd Bergmann <arnd@arndb.de>, gregkh@suse.de, dmitry.torokhov@gmail.com, dtor@mail.ru, rubini@cvml.unipv.it, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-next@vger.kernel.org

On Sun, 16 Jan 2011 01:00:31 +0800
"Guan Xuetao" <guanxuetao@mprc.pku.edu.cn> wrote:

> Hi,
> 
> I want to merge unicore32 repo into linux-next tree, the position is (unicore32 branch):
>   git://git.kernel.org/pub/scm/linux/kernel/git/epip/linux-2.6-unicore32.git
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
> ---

Took a quick look at the PCI parts, looks like you have a pretty big
DMA restriction.

You could provide your own dma map ops and make the allocator a bit
smarter about where it gets memory (preferentially allocating from the
DMA'able region, which you could hide).  Or do you find that swiotlb
does ok in general?

Other than that you had pretty tiny bits of enabling code, I assume
they work on your platform (config space access & setup, etc.).

-- 
Jesse Barnes, Intel Open Source Technology Center
