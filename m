From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Mon, 06 Dec 2010 15:18:23 +0000
Subject: Re: [PATCH] drivers/video/via/viafbdev.c: Check return value of strict_strtoul().
Message-Id: <AANLkTinJNzjkWFpSW2BRmHjC-KLPwnxbM=rLr+juaS+i@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1dda71ee1b12baa2366520b894d83d7b0abefc5c.1291433779.git.tfransosi@gmail.com>
In-Reply-To: <1dda71ee1b12baa2366520b894d83d7b0abefc5c.1291433779.git.tfransosi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Thiago Farina <tfransosi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

On Sat, Dec 4, 2010 at 5:38 AM, Thiago Farina <tfransosi@gmail.com> wrote:
> This fix the following warnings:
>
> drivers/video/via/viafbdev.c:1144: warning: ignoring return value of =91s=
trict_strtoul=92, declared with attribute warn_unused_result

I send patches to convert this code to kstrto*() interfaces,
so this patch would be redundant.
