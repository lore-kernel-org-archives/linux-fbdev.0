From: Dave Airlie <airlied@gmail.com>
Date: Thu, 24 Feb 2011 00:43:40 +0000
Subject: Re: Linux 2.6.38-rc6
Message-Id: <AANLkTi=M0p+=mwRxZpShRU6y6iskEE5+nz6bd+9kek3Y@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTi=TTZ57d1wUz1uH3R6igN8O77iDvSLMW=t86g9V@mail.gmail.com>
	<20110222140349.GA20708@kryptos.osrc.amd.com>
	<AANLkTikESHHfjBqoLFOno6qQz-NXEAo-wBY5JEeAW61N@mail.gmail.com>
	<AANLkTinh4pF7iaUGMcv_9gPy+VBD5POsTHbF_2zPJ17r@mail.gmail.com>
	<AANLkTi=Ys4mb4pc28cH4NMdtMgb2KewJbkXEGJmEP4J0@mail.gmail.com>
	<AANLkTinxHVDwSCouTaZEvR3yTJnSPAas9z6JauGDdS7=@mail.gmail.com>
	<AANLkTinD2cC9dGg2eBtZQhWvhSsuH2BcWDj8byLhWWso@mail.gmail.com>
In-Reply-To: <AANLkTinD2cC9dGg2eBtZQhWvhSsuH2BcWDj8byLhWWso@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anca Emanuel <anca.emanuel@gmail.com>, Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org, Borislav Petkov <bp@amd64.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Feb 24, 2011 at 10:28 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Feb 23, 2011 at 9:16 AM, Anca Emanuel <anca.emanuel@gmail.com> wrote:
>>>
>>> Looks like nouveafb took over from vesafb. Did you do anything special
>>> to trigger this?
>>
>> No. Just boot the system.
>
> Every boot?
>
> And just out of interest, what happens if you don't have the vesafb
> driver at all?
>

I think this is a race condition somewhere with plymouth getting
access to vesafb before it gets kicked off the hw,

I'm assuming removing the vga= line from the command line will stop it,

Dave.
