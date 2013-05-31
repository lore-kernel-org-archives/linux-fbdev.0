From: Timur Tabi <timur@tabi.org>
Date: Fri, 31 May 2013 01:16:16 +0000
Subject: Re: [PATCH v2 2/3] video: xilinxfb: Do not use out_be32 IO function
Message-Id: <CAOZdJXVn9fyhgZKYc9fhJ=Gis9Nqdv1B8EqVNcaswKV5+iCQ1g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <27e53d5633766ab0dc1ac492023d5a0d0199e3aa.1369906849.git.michal.simek@xilinx.com>
	<a15de155a3f32fc1416833df1b281db05d347541.1369906849.git.michal.simek@xilinx.com>
	<3808365.SOUxDqkW9J@wuerfel>
In-Reply-To: <3808365.SOUxDqkW9J@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Simek <michal.simek@xilinx.com>, lkml <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Thu, May 30, 2013 at 5:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> This is probably missing barriers, and is wrong on systems on which
> the endianess of the device is different from the CPU.


I suggest what was done in fsl_ssi.c:

#ifdef PPC
#define read_ssi(addr)             in_be32(addr)
#define write_ssi(val, addr)         out_be32(addr, val)
#define write_ssi_mask(addr, clear, set) clrsetbits_be32(addr, clear, set)
#elif defined ARM
#define read_ssi(addr)             readl(addr)
#define write_ssi(val, addr)         writel(val, addr)
/*
 * FIXME: Proper locking should be added at write_ssi_mask caller level
 * to ensure this register read/modify/write sequence is race free.
 */
static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
{
    u32 val = readl(addr);
    val = (val & ~clear) | set;
    writel(val, addr);
}
#endif
