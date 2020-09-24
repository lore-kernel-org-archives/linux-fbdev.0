From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 24 Sep 2020 16:59:52 +0000
Subject: Re: [PATCH v4 0/4] docs: fb: Removed framebuffer scrollback related documentations
Message-Id: <20200924105952.1448fb46@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1600333774.git.unixbhaskar@gmail.com>
In-Reply-To: <cover.1600333774.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org

On Thu, 17 Sep 2020 15:56:11 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> In this patch series, documentation get in sync with the code removal
> of scrollback,by this commit 50145474f6ef ("fbcon: remove soft scrollback code"),
> by eliminating the information related to it.
> 
> 
> Changes since V3:
> 
> Remove the wrong commit hash and messages from all the 4 patches i.e 
> Commit 973c096f6a85(vgacon: remove software scrollback support)
> from the patches as suggested by Willy and Greg.
> 
> Patch 1: Remove the documentation related to framebuffer scrollback from the file
>    fbcon.rst
> 
> Patch 2: Remove the documentation  boot option for scrollback from the file matroxfb.rst
> 
> Patch 3: Remove the documentation scrollback option from sstfb.rst file.
> 
> Patch 4: Remove the documentation scrollback option from vesafb.rst file. 

Set applied, thanks.

jon
