From: Rob Herring <robh@kernel.org>
Date: Fri, 07 Sep 2018 13:58:41 +0000
Subject: Re: [PATCH 00/21] DT cpu node iterator
Message-Id: <CAL_JsqLvLoekvxcaBMxrboJzqS=NyB69NHLShos+LhETj7zNwQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
 <CAHTX3d+BFKM-jFo8Ww_dXwAzsDVoWqE==erfwVTeijHfh8kkOw@mail.gmail.com>
In-Reply-To: <CAHTX3d+BFKM-jFo8Ww_dXwAzsDVoWqE==erfwVTeijHfh8kkOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <monstr@monstr.eu>
Cc: linux-fbdev@vger.kernel.org, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, SH-Linux <linux-sh@vger.kernel.org>, vitb@kernel.crashing.org, Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>, dri-devel <dri-devel@lists.freedesktop.org>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-clk <linux-clk@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Salter <msalter@redhat.com>, devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, Bartlomiej

On Fri, Sep 7, 2018 at 7:54 AM Michal Simek <monstr@monstr.eu> wrote:
>
> Hi Rob,
>
> 2018-09-05 21:37 GMT+02:00 Rob Herring <robh@kernel.org>:
>>
>> This series adds an iterator for cpu nodes and converts users over to use
>> it or of_get_cpu_node in some cases. This allows us to remove the
>> dependency on device_type property for cpu nodes though removing that
>> from DTS files will have to wait for some time. In some cases, this makes
>> the DT search more strict by only looking in /cpus child nodes rather
>> than any node with the device_type = cpu. The iterator also honors the
>> status property which is often forgotten.
>>
>> I've only tested on ARM under QEMU and compiled powerpc.
>
>
>
> Do you have this somewhere in your tree not to apply 21 patches by hand?

Yes, dt/cpu-type branch on my kernel.org tree.

Rob
