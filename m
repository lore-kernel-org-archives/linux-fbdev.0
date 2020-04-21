From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 21 Apr 2020 15:55:16 +0000
Subject: Re: [PATCH 2/5] powerpc: Replace _ALIGN_DOWN() by ALIGN_DOWN()
Message-Id: <20200421155516.GT26902@gate.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <a5945463f86c984151962a475a3ee56a2893e85d.1587407777.git.christophe.leroy@c-s.fr>
 <3911a86d6b5bfa7ad88cd7c82416fbe6bb47e793.1587407777.git.christophe.leroy@c-s.fr>
 <CACPK8XfqnqgkXcBzp=nqd=AJX1MK05eTNiyOdaEuRu3_6RsXSQ@mail.gmail.com>
In-Reply-To: <CACPK8XfqnqgkXcBzp=nqd=AJX1MK05eTNiyOdaEuRu3_6RsXSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joel Stanley <joel@jms.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-fbdev@vger.kernel.org, kvm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Paul Mackerras <paulus@samba.org>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org

Hi!

On Tue, Apr 21, 2020 at 01:04:05AM +0000, Joel Stanley wrote:
> On Mon, 20 Apr 2020 at 18:38, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> > _ALIGN_DOWN() is specific to powerpc
> > ALIGN_DOWN() is generic and does the same
> >
> > Replace _ALIGN_DOWN() by ALIGN_DOWN()
> 
> This one is a bit less obvious. It becomes (leaving the typeof's alone
> for clarity):
> 
> -((addr)&(~((typeof(addr))(size)-1)))
> +((((addr) - ((size) - 1)) + ((typeof(addr))(size) - 1)) &
> ~((typeof(addr))(size)-1))
> 
> Which I assume the compiler will sort out?

[ This is line-wrapped, something in your mailer?  Took me a bit to figure
  out the - and + are diff -u things :-) ]

In the common case where size is a constant integer power of two, the
compiler will have no problem with this.  But why do so complicated?

Why are the casts there, btw?


Segher
