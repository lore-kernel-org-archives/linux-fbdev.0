From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Dec 2010 03:42:01 +0000
Subject: Re: New entry in modedb
Message-Id: <20101224034201.GL28151@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <EAF47CD23C76F840A9E7FCE10091EFAB0322F86892@dbde02.ent.ti.com>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB0322F86892@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Dec 17, 2010 at 09:09:43PM +0530, Janorkar, Mayuresh wrote:
> We keep a database for modes in drivers/video/modedb.c
> The file says:
> 
> /*
>  *  Standard video mode definitions (taken from XFree86)
>  */
> 
> I am using a panel whose entry is not available in this mode database.
> Can I add a new entry for my panel?
> 
If it's a standard definition that multiple users are likely to use in
the future, sure. We have certainly added new modes in the past based on
expected usage criteria, not limited to the legacy XFree86 definitions.
