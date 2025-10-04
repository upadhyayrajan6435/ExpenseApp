using System;
using System.Data;
using System.Data.SqlClient;
using ExpenseApp.DAL;

namespace ExpenseApp.BLL
{
    public class ApprovalRule
    {
        public static DataTable GetRules(int compId)
        {
            return DB.GetData("sp_GetApprovalRules", new[] {
                new SqlParameter("@CompanyId", compId)
            });
        }

        public static void SaveRule(int compId, string ruleName, string ruleType, int? percentage, int? approverId)
        {
            DB.Execute("sp_SaveApprovalRule", new[] {
                new SqlParameter("@CompanyId", compId),
                new SqlParameter("@RuleName", ruleName),
                new SqlParameter("@RuleType", ruleType),
                new SqlParameter("@PercentageThreshold", (object)percentage ?? DBNull.Value),
                new SqlParameter("@SpecificApproverId", (object)approverId ?? DBNull.Value)
            });
        }

        public static DataTable GetWorkflowSteps(int compId)
        {
            return DB.GetData("sp_GetWorkflowSteps", new[] {
                new SqlParameter("@CompanyId", compId)
            });
        }

        public static void SaveStep(int compId, string stepName, int stepOrder, int requiredRole)
        {
            DB.Execute("sp_SaveWorkflowStep", new[] {
                new SqlParameter("@CompanyId", compId),
                new SqlParameter("@StepName", stepName),
                new SqlParameter("@StepOrder", stepOrder),
                new SqlParameter("@RequiredRole", requiredRole)
            });
        }

        public static void DeleteStep(int stepId)
        {
            DB.Execute("sp_DeleteWorkflowStep", new[] {
                new SqlParameter("@StepId", stepId)
            });
        }
    }
}