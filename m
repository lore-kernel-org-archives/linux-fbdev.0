From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Jul 2010 08:15:44 +0000
Subject: Re: [PATCH 1/6] sh: add a list of parent configurations to struct clk
Message-Id: <AANLkTilW2Tsq0IbYHO4ir_iFpU1n519OqN4MYTUVj3GL@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jun 30, 2010 at 6:55 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Many system clocks can select a parent by writing a value to a specific field
> in the configuration register. Add a list of parents and location and width of
> the source selection field in the clock configuration register to struct clk to
> assist in clk_set_parent() implementation.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Looks good, thank you!
Acked-by: Magnus Damm <damm@opensource.se>
